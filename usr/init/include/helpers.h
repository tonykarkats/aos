#ifndef LIBSOS_HELPERS_H
#define LIBSOS_HELPERS_H

#define ROUND_UP(n, size)           ((((n) + (size) - 1)) & (~((size) - 1)))

// Convert preprocessor macro to string (as recommended by CPP info manual)
#define __xstr(s)       __str(s)
#define __str(s)        #s

#define assert_disabled(e) \
    ((e) ? (void)0 : disp_assert_fail(#e, __FILE__, __func__, __xstr(__LINE__)))

#endif // LIBSOS_HELPERS_H
