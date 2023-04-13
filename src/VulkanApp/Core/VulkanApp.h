#pragma once

#include <Utils/Clock.h>
#include <Window/VulkanWindow.h>

#include <memory>

class VulkanApp
{
public:
	VulkanApp();

	void Run();

protected:
	void Initialize();

	void OnUpdate(Timepoint dt);
	void OnRender(Timepoint dt);

	bool m_ShouldRun = true;
	Timepoint m_LastFrameTime;

	std::unique_ptr<VulkanWindow> m_Window;
};
