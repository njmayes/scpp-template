#include "streamline.h"
#include "Common/EntryPoint.h"

using namespace slc;

class ExampleLayer : public ApplicationLayer
{
public:
	virtual void OnAttach() override {}
	virtual void OnDetach() override {}
	virtual void OnUpdate(Timestep ts) override {}
	virtual void OnRender() override {}
	virtual void OnOverlayRender() override {}

	void OnEvent(Event& e) override
	{
		e.Dispatch<KeyPressedEvent>(SLC_BIND_EVENT_FUNC(OnKeyPressed));
		e.Dispatch<MouseButtonPressedEvent>(SLC_BIND_EVENT_FUNC(OnMouseButtonPressed));
	}

	LISTENING_EVENTS(EventType::KeyPressed, EventType::MouseButtonPressed)

private:
	bool OnKeyPressed(KeyPressedEvent& event) { return false; }
	bool OnMouseButtonPressed(MouseButtonPressedEvent& event) { return false; }
};

class ExampleApp : public Application
{
public:
	ExampleApp(Box<ApplicationSpecification> spec)
		: Application(std::move(spec))
	{
		PushLayer<ExampleLayer>();
	}

	virtual ~ExampleApp()
	{
	}
};

Application* CreateApplication(int argc, char** argv)
{
	Box<ApplicationSpecification> spec = MakeBox<ApplicationSpecification>();
	spec->name = "ExampleApp";

	return new ExampleApp(std::move(spec));
}