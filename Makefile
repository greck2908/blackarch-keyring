V=20180925

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 blackarch{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/blackarch{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=blackarch-keyring-$(V)/ $(V) | gzip -9 > blackarch-keyring-$(V).tar.gz
	gpg --default-key 2AD93F4E --detach-sign --use-agent blackarch-keyring-$(V).tar.gz

upload:
	rsync --chmod 644 --progress blackarch-keyring-$(V).tar.gz blackarch-keyring-$(V).tar.gz.sig blackarch.org:/var/www/keyring/

.PHONY: install uninstall dist upload
