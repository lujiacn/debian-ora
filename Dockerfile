FROM debian:10-slim

ADD distrib /distrib

ENV VERSION="12.2.0.1.0" \
    POSTFIX="12_2" \
    VER="12.2"

ENV ORACLE_HOME=/usr/lib/oracle/instantclient_$POSTFIX \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/oracle/instantclient_$POSTFIX \
    PATH=$PATH:/usr/lib/oracle/instantclient_$POSTFIX

RUN apt-get update && \
    apt-get -y install zip libaio1 && \
    unzip /distrib/instantclient-basiclite-linux.x64-$VERSION.zip -d /usr/lib/oracle && \
    unzip /distrib/instantclient-sdk-linux.x64-$VERSION.zip -d /usr/lib/oracle && \
    rm -rf /distrib

COPY oci8.pc /usr/local/lib/pkgconfig/oci8.pc

# add alias to go so we don't need to provide compilation flags every time
RUN ln -s $(find $ORACLE_HOME -name 'libclntsh.so.*') $ORACLE_HOME/libclntsh.so

