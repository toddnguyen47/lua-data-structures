#include <chrono>
#include <iostream>
#include <iomanip>
#include <stdlib.h> // system

int main(int argc, char **argv)
{
  int numTimes = 1;
  if (argc >= 2)
    numTimes = std::stoi(argv[1]);

  for (int i = 0; i < numTimes; i++)
  {
    std::cout << std::endl
              << "Run Iteration: " << i + 1 << "/" << numTimes << std::endl;

    std::chrono::steady_clock::time_point start_time, end_time;
    int duration1, duration2;

    start_time = std::chrono::steady_clock::now();
    system("lua timetest.lua index");
    end_time = std::chrono::steady_clock::now();
    duration1 = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();
    std::cout << "Split using Index Elapsed Time: ";
    std::cout
        << std::fixed
        << std::setprecision(3)
        << duration1;
    std::cout << " milliseconds" << std::endl;

    start_time = std::chrono::steady_clock::now();
    system("lua timetest.lua strconcat");
    end_time = std::chrono::steady_clock::now();
    duration2 = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time).count();
    std::cout << "Split using String Concat Elapsed Time: ";
    std::cout
        << std::fixed
        << std::setprecision(3)
        << duration2;
    std::cout << " milliseconds" << std::endl;

    std::cout
        << std::endl
        << "Delta Time: "
        << duration2 - duration1
        << " milliseconds"
        << std::endl;
  }
}
