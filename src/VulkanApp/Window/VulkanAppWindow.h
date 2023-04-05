#pragma once

#include <cstdint>
#include <string>

#include <GLFW/glfw3.h>

class VulkanAppWindow
{
public:
	VulkanAppWindow(uint32_t width, uint32_t height, std::string windowTitle);
	~VulkanAppWindow();

	GLFWwindow* Handle() const { return m_WindowHandle; }
	
	// trash idea, should be remade into an event system
	bool Closed() { return glfwWindowShouldClose(m_WindowHandle); }

	void PollEvents() { glfwPollEvents(); }

private:
	GLFWwindow* m_WindowHandle;
	uint32_t m_Width, m_Height;
};
