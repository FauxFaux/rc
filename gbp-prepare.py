#!/usr/bin/python3

import email.parser
import subprocess

def fixup(name, content):
    mail = email.parser.Parser().parsestr(content)
    if 'Description' in mail and 'Subject' not in mail:
        mail['Subject'] = mail['Description']
        del mail['Description']

    if 'Author' in mail and 'From' not in mail:
        mail['From'] = mail['Author']
        del mail['Author']

    if 'Date' not in mail:
        lines = subprocess.check_output(['git', 'log', '--format=%aD', name]).strip().split(b'\n')
        first_authored = next(reversed(lines)).decode('utf-8')
        mail['Date'] = first_authored

    errors = set(mail.keys()) - {'Subject', 'From', 'Date'}

    prefix = ''

    for key in errors:
        prefix += '{}: {}\n'.format(key, mail[key])
        del mail[key]

    mail.set_payload(prefix + mail.get_payload())

    return str(mail)


def main():
    with open('debian/patches/series') as s:
        for line in s:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            name = 'debian/patches/{}'.format(line)
            with open(name) as f:
                new = fixup(name, f.read())
            with open(name, 'w') as f:
                f.write(new)

if '__main__' == __name__:
    main()
