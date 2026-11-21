void psl_free(void *psl) {}
const void *psl_latest(const char *filename) { return 0; }
const void *psl_builtin(void) { return 0; }
const char *psl_check_version_number(int num) { return "0.21.5"; }
int psl_is_cookie_domain_acceptable(const void *psl, const char *hostname, const char *cookie_domain) { return 1; }
