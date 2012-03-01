BUNDLE = lv2pftci-fullbacano.lv2
INSTALL_DIR = /usr/local/lib/lv2


$(BUNDLE): manifest.ttl fullbacano.ttl fullbacano.so
	rm -rf $(BUNDLE)
	mkdir $(BUNDLE)
	cp manifest.ttl fullbacano.ttl fullbacano.so $(BUNDLE)

fullbacano.so: fullbacano.cpp
	g++ -shared -fPIC -DPIC fullbacano.cpp `pkg-config --cflags --libs lv2-plugin` -o fullbacano.so

install: $(BUNDLE)
	mkdir -p $(INSTALL_DIR)
	rm -rf $(INSTALL_DIR)/$(BUNDLE)
	cp -R $(BUNDLE) $(INSTALL_DIR)

clean:
	rm -rf $(BUNDLE) fullbacano.so
