/** based on xprintidle */

#include <X11/Xlib.h>
#include <X11/extensions/dpms.h>
#include <X11/extensions/scrnsaver.h>

unsigned long workaroundCreepyXServer(Display *dpy, unsigned long _idleTime );

XScreenSaverInfo *ssi = NULL;
Display *dpy = NULL;

void initfn() __attribute__((constructor));
void release() __attribute__((destructor));

void initfn()
{
    int event_basep, error_basep;
    dpy = XOpenDisplay(NULL);
    if (NULL == dpy) {
        release();
        return;
    }

    if (!XScreenSaverQueryExtension(dpy, &event_basep, &error_basep)) {
        release();
        return;
    }

    ssi = XScreenSaverAllocInfo();
    if (ssi == NULL) {
        release();
        return;
    }
}

long get() {
    if (NULL == dpy || NULL == ssi) {
        return -2;
    }

    if (!XScreenSaverQueryInfo(dpy, DefaultRootWindow(dpy), ssi)) {
        return -1;
    }

    return workaroundCreepyXServer(dpy, ssi->idle);
}

void release() {
    if (NULL != ssi) {
        XFree(ssi);
        ssi = NULL;
    }
    if (NULL != dpy) {
        XCloseDisplay(dpy);
        dpy = NULL;
    }
}

/*!
 * This function works around an XServer idleTime bug in the
 * XScreenSaverExtension if dpms is running. In this case the current
 * dpms-state time is always subtracted from the current idletime.
 * This means: XScreenSaverInfo->idle is not the time since the last
 * user activity, as descriped in the header file of the extension.
 * This result in SUSE bug # and sf.net bug #. The bug in the XServer itself
 * is reported at https://bugs.freedesktop.org/buglist.cgi?quicksearch=6439.
 *
 * Workaround: Check if if XServer is in a dpms state, check the 
 *             current timeout for this state and add this value to 
 *             the current idle time and return.
 *
 * \param _idleTime a unsigned long value with the current idletime from
 *                  XScreenSaverInfo->idle
 * \return a unsigned long with the corrected idletime
 */
unsigned long workaroundCreepyXServer(Display *dpy, unsigned long _idleTime ){
    int dummy;
    CARD16 standby, suspend, off;
    CARD16 state;
    BOOL onoff;

    if (DPMSQueryExtension(dpy, &dummy, &dummy)) {
        if (DPMSCapable(dpy)) {
            DPMSGetTimeouts(dpy, &standby, &suspend, &off);
            DPMSInfo(dpy, &state, &onoff);

            if (onoff) {
                switch (state) {
                    case DPMSModeStandby:
                        /* this check is a littlebit paranoid, but be sure */
                        if (_idleTime < (unsigned) (standby * 1000))
                            _idleTime += (standby * 1000);
                        break;
                    case DPMSModeSuspend:
                        if (_idleTime < (unsigned) ((suspend + standby) * 1000))
                            _idleTime += ((suspend + standby) * 1000);
                        break;
                    case DPMSModeOff:
                        if (_idleTime < (unsigned) ((off + suspend + standby) * 1000))
                            _idleTime += ((off + suspend + standby) * 1000);
                        break;
                    case DPMSModeOn:
                    default:
                        break;
                }
            }
        } 
    }

    return _idleTime;
}

