#include <iio/iio.h>
#include <iio/iio-debug.h>

#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <signal.h>
#include <stdio.h>
#include <errno.h>
#include <math.h>
#include <iostream>
#include <fstream>

/* helper macros */
#define MHZ(x) ((long long)(x*1000000.0 + .5))
#define GHZ(x) ((long long)(x*1000000000.0 + .5))


/* IIO structs required for streaming */
static struct iio_context *ctx   = NULL;
static struct iio_channel *rx0_i = NULL;
static struct iio_channel *rx0_q = NULL;
static struct iio_channel *tx0_i = NULL;
static struct iio_channel *tx0_q = NULL;
static struct iio_buffer  *rxbuf = NULL;
static struct iio_buffer  *txbuf = NULL;
static struct iio_stream  *rxstream = NULL;
static struct iio_stream  *txstream = NULL;
static struct iio_channels_mask *rxmask = NULL;
static struct iio_channels_mask *txmask = NULL;



/* cleanup and exit */
static void shutdown(void)
{
	printf("* Destroying streams\n");
	if (rxstream) {iio_stream_destroy(rxstream); }
	if (txstream) { iio_stream_destroy(txstream); }

	printf("* Destroying buffers\n");
	if (rxbuf) { iio_buffer_destroy(rxbuf); }
	if (txbuf) { iio_buffer_destroy(txbuf); }

	printf("* Destroying channel masks\n");
	if (rxmask) { iio_channels_mask_destroy(rxmask); }
	if (txmask) { iio_channels_mask_destroy(txmask); }

	printf("* Destroying context\n");
	if (ctx) { iio_context_destroy(ctx); }
}

struct sigaction old_action;

void sigint_handler(int sig_no)
{
    printf("CTRL-C pressed\n");
    sigaction(SIGINT, &old_action, NULL);
    shutdown();
    exit(0);
}

struct stream_cfg {
	long long bw_hz;
	long long fs_hz;
	long long lo_hz;
	const char* rfport;
};

int main() { 
    struct stream_cfg rxcfg;
	struct stream_cfg txcfg;

    rxcfg.bw_hz = MHZ(1);   // 2 MHz rf bandwidth
	rxcfg.fs_hz = MHZ(2);   // 2.5 MS/s rx sample rate
	rxcfg.lo_hz = MHZ(900); // 2.5 GHz rf frequency
	rxcfg.rfport = "A_BALANCED"; // port A (select for rf freq.)

	// TX stream config
	txcfg.bw_hz = MHZ(1); // 1 MHz rf bandwidth
	txcfg.fs_hz = MHZ(2);   // 2.5 MS/s tx sample rate
	txcfg.lo_hz = MHZ(1000); // 2.5 GHz rf frequency
	txcfg.rfport = "A"; // port A (select for rf freq.)


    // Initialize IIO context
    ctx = iio_create_context(NULL, "ip:192.168.2.1");
    if(!ctx){
        std::cerr << "Unable to create IIO context addr: " << "ip:192.168.2.1" << std::endl;
        return 1;
    } else {
        std::cout << "IIO context created successfully, addr: " << "ip:192.168.2.1" << std::endl;
    }
}