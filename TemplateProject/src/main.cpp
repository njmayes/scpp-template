#include "streamline.h"
#include "Common/EntryPoint.h"

using namespace slc;

class ExampleLayer : public ILayer
{
public:
	virtual void OnAttach() override {}
	virtual void OnDetach() override {}
	virtual void OnRender() override {}

	void OnEvent(Event& e) override
	{
		e.Dispatch<KeyPressedEvent>(SLC_BIND_EVENT_FUNC(OnKeyPressed));
		e.Dispatch<MouseButtonPressedEvent>(SLC_BIND_EVENT_FUNC(OnMouseButtonPressed));
	}

	LISTENING_EVENTS(KeyPressed, MouseButtonPressed)

private:
	bool OnKeyPressed(KeyPressedEvent& event) { return false; }
	bool OnMouseButtonPressed(MouseButtonPressedEvent& event) { return false; }
};

class ExampleApp : public Application
{
public:
	ExampleApp(const ApplicationSpecification& spec)
		: Application(spec)
	{
		PushLayer<ExampleLayer>();
	}

	virtual ~ExampleApp()
	{
	}
};

Impl<Application> CreateApplication(int argc, char** argv)
{
	ApplicationSpecification spec;
	spec.name = "ExampleApp";

	return MakeImpl<ExampleApp>(spec);
}