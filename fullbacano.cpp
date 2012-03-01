#include <lv2plugin.hpp>


using namespace LV2;


class FullBacano: public Plugin<FullBacano> {
public:
  
  FullBacano(double rate)
    : Plugin<FullBacano>(6) {
    
  }
  
  void run(uint32_t nframes) {
    
    float width = *p(0);
    float balance = *p(1);
    
    width = width < 0 ? 0 : width;
    width = width > 1 ? 1 : width;
    balance = balance < -1 ? -1 : balance;
    balance = balance > 1 ? 1 : balance;
    
    for (uint32_t i = 0; i < nframes; ++i) {
      float mid = (p(2)[i] + p(3)[i]) / 2;
      float side = (p(2)[i] - p(3)[i]) / 2;
      p(4)[i] = (mid + width * side) * 2 / (1 + width);
      p(5)[i] = (mid - width * side) * 2 / (1 + width);
      if (balance < 0)
	p(5)[i] *= 1 + balance;
      else
	p(4)[i] *= 1 - balance;	
    }
  }

};


static int _ = FullBacano::register_class("http://ll-plugins.nongnu.org/lv2/lv2pftci/fullbacano");
