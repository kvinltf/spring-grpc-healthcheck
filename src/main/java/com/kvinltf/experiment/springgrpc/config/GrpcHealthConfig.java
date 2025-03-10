package com.kvinltf.experiment.springgrpc.config;

import io.grpc.Grpc;
import io.grpc.InsecureServerCredentials;
import io.grpc.Server;
import io.grpc.protobuf.services.HealthStatusManager;
import io.grpc.protobuf.services.ProtoReflectionService;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
public class GrpcHealthConfig {

    private static final Logger log = LoggerFactory.getLogger(GrpcHealthConfig.class);

    @PostConstruct
    public void grpcServer() throws IOException, InterruptedException {
        Server server = Grpc.newServerBuilderForPort(9064, InsecureServerCredentials.create())
                .addService(new HealthStatusManager().getHealthService())
                .addService(ProtoReflectionService.newInstance())
                .build();

        log.info("Starting grpc server");
        server.start();

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            log.info("Shutting down grpc server");
            server.shutdown();
        }));


    }


}
