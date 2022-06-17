load("@rules_java//java:defs.bzl", "java_binary", "java_library")

package(default_visibility = ["//visibility:public"])

java_library(
    name = "java-maven-lib",
    srcs = glob(["src/main/java/com/bills/pay/*.java"]),
    deps = [
        "@maven//:org_springframework_boot_spring_boot_autoconfigure",
        "@maven//:org_springframework_boot_spring_boot",
        "@maven//:org_springframework_boot_spring_boot_starter_mail",
        "@maven//:org_springframework_boot_spring_boot_starter",
        "@maven//:org_springframework_boot_spring_boot_starter_test",
        "@maven//:org_springframework_boot_spring_boot_devtools",
        "@maven//:org_springframework_boot_spring_boot_starter_validation",
        "@maven//:org_springframework_boot_spring_boot_starter_web",
        "@maven//:org_springframework_boot_spring_boot_starter_thymeleaf",
        "@maven//:org_springframework_boot_spring_boot_starter_data_jpa",
        "@maven//:org_springframework_data_spring_data_commons",
        "@maven//:org_projectlombok_lombok",
        "@maven//:org_projectlombok_lombok_maven_plugin",
        "@maven//:org_postgresql_postgresql",
        "@maven//:com_h2database_h2",
        "@maven//:javax_ws_rs_javax_ws_rs_api",
        "@maven//:org_junit_jupiter_junit_jupiter",
        "@maven//:com_sun_mail_javax_mail",
    ],
)

java_binary(
    name = "java-maven",
    main_class = "com.bills.pay.PayApplication",
    runtime_deps = [":java-maven-lib"],
)

# java_test(
#     name = "tests",
#     srcs = glob(["src/test/java/com/example/myproject/*.java"]),
#     test_class = "com.example.myproject.TestApp",
#     deps = [
#         ":java-maven-lib",
#         "@maven//:com_google_guava_guava",
#         "@maven//:junit_junit",
#     ],
# )