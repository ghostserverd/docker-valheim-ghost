# -------------------- #
# -- Valheim Server -- #
# -------------------- #
FROM mbround18/valheim

RUN apt-get update && apt-get install -y \
    unzip

# ------------------ #
# -- Goldberg Emu -- #
# ------------------ #
RUN wget https://gitlab.com/Mr_Goldberg/goldberg_emulator/-/jobs/1034305976/artifacts/download -O /home/goldberg_emulator.zip && \
    mkdir /home/goldberg/ && \
    unzip /home/goldberg_emulator.zip -d /home/goldberg && \
    rm -r /home/goldberg_emulator.zip

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
CMD ["/bin/bash", "/home/steam/scripts/start_valheim.sh"]
