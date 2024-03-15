.PHONY: deploy
deploy: book
	@echo "====> deploying to github"
	mdbook build
	rm -rf /tmp/book
	git worktree add -f /tmp/book gh-pages
	rm -rf /tmp/book/*
	cp -rp book/* /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages --force