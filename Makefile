proj_name=sphinx_docs_test
make:
	echo "hello"
upload_test_pypi:
	rm -rf dist || True
	python setup.py sdist
	twine -r testpypi dist/* 
upload_pypi:
	rm -rf dist || True
	python setup.py sdist
	twine upload dist/* 
docs: clean_docs
	mkdir -p sphinx
	mkdir -p docs || True
	touch docs/.nojekyll
	sphinx-quickstart sphinx --sep --project TestDocs --author MatteoLacki -v 0.0.1 --ext-autodoc --ext-githubpages --extensions sphinx.ext.napoleon --extensions recommonmark --makefile -q --no-batchfile
	sphinx-apidoc -f -o sphinx/source sphinx_docs_test
	cd sphinx && make html
	cp -r sphinx/build/html/* docs
clean_docs:
	rm -rf sphinx
	rm -rf docs
