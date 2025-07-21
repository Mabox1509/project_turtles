//[INSTANCIATE CURSOR]
started = false;

time = 0;
ended = false;

window_set_caption(GAME_NAME);

global.screen_fade = 0;
obj_screen.fade = 0;

//[LOAD]
settings_load();
load_language(global.settings.lang);

alarm[0] = 3;
