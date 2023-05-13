#include <utils/thread.hpp>
#include <utils/hook.hpp>
#include <utils/flags.hpp>
#include <utils/concurrency.hpp>
#include <utils/image.hpp>

#define CONSOLE_BUFFER_SIZE 16384
#define WINDOW_WIDTH 608





namespace console
{
	namespace
	{
		utils::image::object logo;
		std::atomic_bool started{ false };
		std::atomic_bool terminate_runner{ false };
	}
}