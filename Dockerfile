FROM oracle/graalvm-ce:1.0.0-rc15 as graalvm
COPY . /home/app/contracts
WORKDIR /home/app/contracts
RUN native-image --no-server -cp target/contracts-*.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/contracts .
ENTRYPOINT ["./contracts"]
