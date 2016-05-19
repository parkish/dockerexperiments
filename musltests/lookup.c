#define _POSIX_SOURCE
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

int main(int argc, char**argv) {
	for (int i = 1; i < argc; ++i) {	
		printf("Looking up %s\n", argv[i]);
		struct hostent *he = gethostbyname(argv[i]);

		if (he == NULL) {
			printf("Failed to lookup host %s : %d\n", argv[i], errno);
			continue;
		}
		
		struct in_addr **addr_list = (struct in_addr **) he->h_addr_list;
		
		for (int j = 0; addr_list[j] != NULL; ++j) {
			char ipstr[16] = {0};
			inet_ntop(AF_INET, (void*)addr_list[j], ipstr, sizeof(ipstr));
			
			printf("IP: %s\n", ipstr);
		}
	}
}
