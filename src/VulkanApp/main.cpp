#include <stdexcept>
#include <iostream>

#include <Entrypoint.h>

class DerivedClientAppLayer : public ClientAppLayer
{
public:
	virtual void OnUpdate() override
	{
		m_Counter++;
	}

	virtual void OnRender() override
	{
	}
private:
	inline static int m_Counter = 0;
};

std::shared_ptr<ClientAppLayer> CreateClientAppLayer()
{
	return std::make_shared<DerivedClientAppLayer>();
}