BUNDLE = lv2pftci-stereopanner.lv2
INSTALL_DIR = /usr/local/lib/lv2


$(BUNDLE): manifest.ttl stereopanner.ttl stereopanner.so
	rm -rf $(BUNDLE)
	mkdir $(BUNDLE)
	cp manifest.ttl stereopanner.ttl stereopanner.so $(BUNDLE)

stereopanner.so: stereopanner.cpp
	g++ -shared -fPIC -DPIC stereopanner.cpp `pkg-config --cflags --libs lv2-plugin` -o stereopanner.so

install: $(BUNDLE)
	mkdir -p $(INSTALL_DIR)
	rm -rf $(INSTALL_DIR)/$(BUNDLE)
	cp -R $(BUNDLE) $(INSTALL_DIR)

clean:
	rm -rf $(BUNDLE) stereopanner.so
