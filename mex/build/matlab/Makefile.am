ACLOCAL_AMFLAGS = -I ../../../m4

# libdynare++ must come before gensylv, k_order_perturbation, dynare_simul_

if DO_SOMETHING
SUBDIRS = mjdgges kronecker bytecode libdynare++ gensylv block_kalman_filter sobol local_state_space_iterations

if HAVE_MATIO
SUBDIRS += k_order_perturbation dynare_simul_
endif

if HAVE_GSL
SUBDIRS += ms_sbvar
endif

if HAVE_SLICOT
SUBDIRS += kalman_steady_state
endif

if HAVE_M2HTML
html-local:
	echo "addpath ${M2HTML}" > run_m2html.m
	echo "cd ../../.." >> run_m2html.m
	echo "m2html('mFiles', 'matlab', 'htmlDir', 'doc/m2html', 'recursive', 'on', 'globalHypertextLinks', 'on')" >> run_m2html.m
	echo "quit" >> run_m2html.m
	$(MATLAB)/bin/matlab -r run_m2html # Not using the -nodisplay option, because with m2html it confuses the terminal (need to do a "reset")

clean-local:
	rm -f run_m2html.m
	rm -rf ../../../doc/m2html
endif

install-exec-local:
	$(MKDIR_P) $(DESTDIR)$(pkglibdir)/mex/matlab
endif

EXTRA_DIST = mex.def mexFunction-MacOSX.map
