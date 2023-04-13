#pragma once

#include <Core/VulkanApp.h>

#include <stdexcept>
#include <iostream>

int main()
{
    try
    {
        VulkanApp app;
        app.Run();
    }
    catch (std::runtime_error e)
    {
        std::cout << "Runtime error: " << e.what() << std::endl;
        return -1;
    }

    return 0;
}
