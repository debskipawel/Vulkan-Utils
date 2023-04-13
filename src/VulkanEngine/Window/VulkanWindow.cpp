#include "VulkanWindow.h"

#include <GLFW/glfw3.h>

VulkanWindow::VulkanWindow(uint32_t width, uint32_t height, std::string windowTitle)
	: m_Width(width), m_Height(height)
{
	glfwInit();

	glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
	glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

	m_WindowHandle = glfwCreateWindow(
		m_Width, m_Height,
		windowTitle.c_str(),
		nullptr, nullptr
	);
}

VulkanWindow::~VulkanWindow()
{
	glfwDestroyWindow(static_cast<GLFWwindow*>(m_WindowHandle));
	glfwTerminate();
}

bool VulkanWindow::Closed()
{
	return glfwWindowShouldClose(static_cast<GLFWwindow*>(m_WindowHandle));
}

void VulkanWindow::PollEvents()
{
	glfwPollEvents();
}
