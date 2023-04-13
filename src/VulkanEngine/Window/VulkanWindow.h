#pragma once

#include <cstdint>
#include <string>

class VulkanWindow
{
public:
	VulkanWindow(uint32_t width, uint32_t height, std::string windowTitle);
	~VulkanWindow();

	void* Handle() const { return m_WindowHandle; }
	bool Closed();

	void PollEvents();

private:
	void* m_WindowHandle;
	uint32_t m_Width, m_Height;
};
