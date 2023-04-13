#pragma once

#include <memory>

class ClientAppLayer
{
public:
	virtual void OnUpdate() = 0;
	virtual void OnRender() = 0;
};

extern std::shared_ptr<ClientAppLayer> CreateClientAppLayer();
