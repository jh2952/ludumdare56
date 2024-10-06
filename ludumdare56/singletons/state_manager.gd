extends Node

enum
{
	STATE_START,
	STATE_TRANSITIONING_INTO_GAME,
	STATE_GAME,
	STATE_TRANSITIONING_OUT_GAME,
	STATE_SHOP,
	STATE_TOTAL,
}

var current_state = STATE_START

static var is_fly_audio_playing = false
