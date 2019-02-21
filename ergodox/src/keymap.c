#include "ergodox_ez.h"
#include "debug.h"
#include "action_layer.h"
#include "version.h"
#include "keymap_german.h"
#include "keymap_nordic.h"
#include "keymap_french.h"
#include "keymap_spanish.h"

#define LCGS(code) LCTL(LGUI(LSFT(code)))
#define LCS(code) LCTL(LSFT(code))

enum custom_keycodes {
  PLACEHOLDER = SAFE_RANGE,              // can always be here
  EPRM,                   
  RGB_SLD,                
  
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [0] = LAYOUT_ergodox(
    // left hand
    KC_GRV,                 KC_1,                   KC_2,                   KC_3,                   KC_4,                   KC_5,                   KC_PSCR,                
    KC_LCMD,                KC_Q,                   KC_W,                   KC_F,                   KC_P,                   KC_G,                   KC_UP,                  
    KC_BSPC,                KC_A,                   KC_R,                   KC_S,                   KC_T,                   KC_D,                   
    KC_LSPO,                KC_Z,                   KC_X,                   KC_C,                   KC_V,                   KC_B,                   KC_LEFT,                
    KC_LCTL,                MO(1),                  KC_LALT,                KC_LCMD,                MO(2),                  
                                                                                                                            KC_DEL,                 KC_HOME,                
                                                                                                                                                    KC_END,                 
                                                                                                    KC_SPC,                 KC_LALT,                KC_ESC,                 
        // right hand
        KC_PAUS,                KC_6,                   KC_7,                   KC_8,                   KC_9,                   KC_0,                   KC_MINS,                
        KC_DOWN,                KC_J,                   KC_L,                   KC_U,                   KC_Y,                   KC_SCLN,                KC_EQL,                 
                                KC_H,                   KC_N,                   KC_E,                   KC_I,                   KC_O,                   KC_QUOT,                
        KC_RGHT,                KC_K,                   KC_M,                   KC_COMM,                KC_DOT,                 KC_SLSH,                KC_RSPC,                
        MO(1),                  KC_RCMD,                RALT_T(KC_APP),         _______,                KC_RCTL,                
        KC_INS,                 KC_MPLY,                
        KC_PGUP,                
        KC_PGDN,                KC_TAB,                 KC_ENT
    ),


  [1] = LAYOUT_ergodox(
    // left hand
    _______,                _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                KC_CIRC,                KC_AMPR,                KC_ASTR,                _______,                
    _______,                _______,                LSFT(XXXXXXXNUS_BSLASH),KC_LCBR,                KC_RCBR,                LSFT(XXXXXXXNUS_HASH),  
    _______,                _______,                XXXXXXXNUS_BSLASH,      KC_LBRC,                KC_RBRC,                XXXXXXXNUS_HASH,        _______,                
    _______,                _______,                TO(3),                  TO(4),                  TO(2),                  
                                                                                                                            KC_MPRV,                KC_MNXT,                
                                                                                                                                                    KC_CALC,                
                                                                                                    _______,                _______,                KC_WSCH,                
        // right hand
        _______,                _______,                _______,                _______,                _______,                _______,                _______,                
        _______,                _______,                KC_PERC,                KC_CIRC,                KC_AMPR,                KC_ASTR,                _______,                
                                _______,                KC_EXLM,                KC_PERC,                KC_HASH,                KC_DLR,                 _______,                
        _______,                _______,                _______,                _______,                _______,                _______,                _______,                
        _______,                _______,                _______,                TO(0),                  _______,                
        KC_MUTE,                _______,                
        KC_VOLU,                
        KC_VOLD,                _______,                _______
    ),


  [2] = LAYOUT_ergodox(
    // left hand
    _______,                KC_F1,                  KC_F2,                  KC_F3,                  KC_F4,                  KC_F5,                  _______,                
    _______,                _______,                KC_BTN2,                KC_MS_U,                KC_BTN1,                _______,                _______,                
    _______,                _______,                KC_MS_L,                KC_MS_D,                KC_MS_R,                _______,                
    _______,                _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                _______,                _______,                
                                                                                                                            _______,                _______,                
                                                                                                                                                    _______,                
                                                                                                    _______,                _______,                _______,                
        // right hand
        _______,                KC_F6,                  KC_F7,                  KC_F8,                  KC_F9,                  KC_F10,                 KC_F11,                 
        _______,                KC_7,                   KC_8,                   KC_9,                   KC_PMNS,                _______,                KC_F12,                 
                                KC_4,                   KC_5,                   KC_6,                   KC_PPLS,                _______,                _______,                
        _______,                KC_1,                   KC_2,                   KC_3,                   _______,                _______,                _______,                
        KC_P0,                  KC_PDOT,                _______,                TO(0),                  _______,                
        _______,                _______,                
        _______,                
        _______,                _______,                _______
    ),


  [3] = LAYOUT_ergodox(
    // left hand
    KC_GRV,                 KC_1,                   KC_2,                   KC_3,                   KC_4,                   KC_5,                   _______,                
    KC_TAB,                 KC_Q,                   KC_W,                   KC_E,                   KC_R,                   KC_T,                   KC_UP,                  
    KC_BSPC,                KC_A,                   KC_S,                   KC_D,                   KC_F,                   KC_G,                   
    KC_LSFT,                KC_Z,                   KC_X,                   KC_C,                   KC_V,                   KC_B,                   KC_LEFT,                
    KC_LCTL,                XXXXXXXNUS_BSLASH,      KC_LALT,                KC_LCMD,                _______,                
                                                                                                                            KC_DEL,                 KC_HOME,                
                                                                                                                                                    KC_END,                 
                                                                                                    KC_SPC,                 KC_LALT,                KC_ESC,                 
        // right hand
        KC_PSCR,                KC_6,                   KC_7,                   KC_8,                   KC_9,                   KC_0,                   KC_MINS,                
        KC_DOWN,                KC_Y,                   KC_U,                   KC_I,                   KC_O,                   KC_P,                   KC_EQL,                 
                                KC_H,                   KC_J,                   KC_K,                   KC_L,                   KC_SCLN,                KC_QUOT,                
        KC_RGHT,                KC_N,                   KC_M,                   KC_COMM,                KC_DOT,                 KC_SLSH,                KC_RSFT,                
        XXXXXXXNUS_HASH,        KC_RCMD,                RALT_T(KC_APP),         TO(0),                  KC_RCTL,                
        KC_INS,                 KC_MPLY,                
        KC_PGUP,                
        KC_PGDN,                _______,                KC_ENT
    ),


  [4] = LAYOUT_ergodox(
    // left hand
    _______,                _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                _______,                _______,                _______,                _______,                
    _______,                _______,                _______,                _______,                _______,                
                                                                                                                            RGB_MOD,                _______,                
                                                                                                                                                    _______,                
                                                                                                    RGB_VAD,                RGB_VAI,                _______,                
        // right hand
        RESET,                  _______,                _______,                _______,                _______,                _______,                _______,                
        _______,                _______,                _______,                _______,                _______,                _______,                _______,                
                                _______,                _______,                _______,                _______,                _______,                _______,                
        _______,                _______,                _______,                _______,                _______,                _______,                _______,                
        _______,                _______,                _______,                TO(0),                  _______,                
        RGB_TOG,                RGB_SLD,                
        _______,                
        _______,                RGB_HUD,                RGB_HUI
    ),


};

bool suspended = false;
const uint16_t PROGMEM fn_actions[] = {
  [1] = ACTION_LAYER_TAP_TOGGLE(1)
};

// leaving this in place for compatibilty with old keymaps cloned and re-compiled.
const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
      switch(id) {
        case 0:
        if (record->event.pressed) {
          SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
        }
        break;
      }
    return MACRO_NONE;
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    // dynamically generate these.
    case EPRM:
      if (record->event.pressed) {
        eeconfig_init();
      }
      return false;
      break;
    case RGB_SLD:
      if (record->event.pressed) {
        rgblight_mode(1);
      }
      return false;
      break;
  }
  return true;
}

uint32_t layer_state_set_user(uint32_t state) {

    uint8_t layer = biton32(state);

    ergodox_board_led_off();
    ergodox_right_led_1_off();
    ergodox_right_led_2_off();
    ergodox_right_led_3_off();
    switch (layer) {
      case 1:
        ergodox_right_led_1_on();
        break;
      case 2:
        ergodox_right_led_2_on();
        break;
      case 3:
        ergodox_right_led_3_on();
        break;
      case 4:
        ergodox_right_led_1_on();
        ergodox_right_led_2_on();
        break;
      case 5:
        ergodox_right_led_1_on();
        ergodox_right_led_3_on();
        break;
      case 6:
        ergodox_right_led_2_on();
        ergodox_right_led_3_on();
        break;
      case 7:
        ergodox_right_led_1_on();
        ergodox_right_led_2_on();
        ergodox_right_led_3_on();
        break;
      default:
        break;
    }
    return state;

};
