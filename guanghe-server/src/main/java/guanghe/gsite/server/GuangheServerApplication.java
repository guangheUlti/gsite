package guanghe.gsite.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
 * 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
 * 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
 *
 * @author 光何
 */
@SuppressWarnings("SpringComponentScan") // 忽略 IDEA 无法识别 ${guanghe.info.base-package}
@SpringBootApplication(scanBasePackages = {"${guanghe.info.base-package}.server", "${guanghe.info.base-package}.module"})
public class GuangheServerApplication {

    public static void main(String[] args) {
        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章

        SpringApplication.run(GuangheServerApplication.class, args);
//        new SpringApplicationBuilder(GuangheServerApplication.class)
//                .applicationStartup(new BufferingApplicationStartup(20480))
//                .run(args);

        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
        // 如果你碰到启动的问题，请认真阅读 https://github.com/guangheUlti/gsite 文章
    }

}
