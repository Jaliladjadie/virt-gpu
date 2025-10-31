FROM gcc AS build

WORKDIR /
COPY src/firmware.c .
RUN gcc -Wall -Wextra -static firmware.c -o firmware



FROM scratch AS final

WORKDIR /

COPY --from=build /firmware .
COPY src/rootfs .

CMD ["/firmware"]
