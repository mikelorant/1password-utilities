FROM alpine

RUN apk add --no-cache \
      perl \
      perl-doc \
      perl-text-csv \
      perl-xml-xpath \
      perl-date-calc \
      perl-carp-clan \
      perl-slurp \
      git \
      wget \
      build-base

RUN wget -O - https://cpanmin.us | perl - --self-upgrade

RUN cpanm RTF::Tokenizer File::Type

WORKDIR /root

RUN git clone https://github.com/agilebits/onepassword-utilities.git

WORKDIR onepassword-utilities/convert_to_1p4

RUN chmod 755 convert_to_1p4.pl

RUN ln -s ${PWD}/convert_to_1p4.pl /usr/local/bin/convert_to_1p4

ENTRYPOINT ["/usr/local/bin/convert_to_1p4"]
