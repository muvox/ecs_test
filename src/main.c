#include <iostream>
#include "game.h"

static int runApp(Application* app){
	Window window(*app, 800, 600, "Test iquna");
	RenderDevice device(window);
	Sampler sampler(device, RenderDevice::FILTER_LINEAR_MIPMAP_LINEAR);

	
}
