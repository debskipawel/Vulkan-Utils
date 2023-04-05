#include "VulkanApp.h"

VulkanApp::VulkanApp()
	: m_LastFrameTime(0.0f), m_ShouldRun(true)
{
}

void VulkanApp::Initialize()
{
	Clock::Initialize();

	m_Window = std::make_unique<VulkanAppWindow>(800, 600, "Vulkan window");
}

void VulkanApp::Run()
{
	Initialize();

	while (m_ShouldRun)
	{
		auto currentFrameTime = Clock::Now();
		auto deltaTime = currentFrameTime - m_LastFrameTime;

		m_LastFrameTime = currentFrameTime;

		OnUpdate(deltaTime);
		OnRender(deltaTime);
	}
}

void VulkanApp::OnUpdate(Timepoint dt)
{
	m_Window->PollEvents();

	m_ShouldRun = !m_Window->Closed();
}

void VulkanApp::OnRender(Timepoint dt)
{
}
