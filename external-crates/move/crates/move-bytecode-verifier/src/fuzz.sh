while test $# -gt 0; do
    case "$1" in
        # -b)
        #     # clean up
        #     cargo +fuzz clean
        #     rm -rf ${TARGET}

        #     # build the crates
        #     PAFL=${TARGET} PAFL_TARGET_PREFIX=${PREFIX} \
        #     cargo +fuzz test \
        #         regression_tests::fuzz::miri_path_fuzz -- \
        #         --exact
        #     ;;
        -nomiri) # bytecode-source-map
            cargo +fuzz test test_empty_module -- --exact
            ;;
        -miri)
            cargo +fuzz miri test test_empty_module -- --exact
            ;;
        -v) # bytecode-verifier
            cargo +fuzz test \
            regression_tests::reference_analysis::indirect_code -- \
            --exact
            ;;
        -my)
            cargo +fuzz test \
            mutate::test_mutate_and_verify_module -- \
            --exact --nocapture
            ;;
        -mymiri)
            cargo +fuzz miri test \
            mutate::test_mutate_and_verify_module -- \
            --exact --nocapture
            ;;
        *)
            echo "invalid argument $1"
            exit 1
            ;;
    esac
    shift
done