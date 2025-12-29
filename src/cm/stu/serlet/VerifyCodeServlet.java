package cm.stu.serlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@WebServlet("/verifyCode")
public class VerifyCodeServlet extends HttpServlet {
    // 验证码字符集
    private static final String VERIFY_CODES = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // 验证码长度
    private static final int CODE_LENGTH = 4;
    // 图片宽度
    private static final int IMG_WIDTH = 100;
    // 图片高度
    private static final int IMG_HEIGHT = 30;
    // 干扰线数量
    private static final int LINE_COUNT = 20;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 创建图像
        BufferedImage image = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();

        // 生成随机数
        Random random = new Random();

        // 设置背景色
        g.setColor(getRandColor(200, 250));
        g.fillRect(0, 0, IMG_WIDTH, IMG_HEIGHT);

        // 设置字体
        g.setFont(new Font("Times New Roman", Font.PLAIN, 24));

        // 绘制干扰线
        for (int i = 0; i < LINE_COUNT; i++) {
            int x1 = random.nextInt(IMG_WIDTH);
            int y1 = random.nextInt(IMG_HEIGHT);
            int x2 = random.nextInt(IMG_WIDTH);
            int y2 = random.nextInt(IMG_HEIGHT);
            g.setColor(getRandColor(160, 200));
            g.drawLine(x1, y1, x2, y2);
        }

        // 生成验证码
        StringBuilder verifyCode = new StringBuilder();
        for (int i = 0; i < CODE_LENGTH; i++) {
            String code = String.valueOf(VERIFY_CODES.charAt(random.nextInt(VERIFY_CODES.length())));
            verifyCode.append(code);
            // 绘制验证码
            g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
            g.drawString(code, 20 * i + 10, 25);
        }

        // 释放图形资源
        g.dispose();

        // 将验证码存入Session
        HttpSession session = request.getSession();
        session.setAttribute("verifyCode", verifyCode.toString());

        // 设置响应头信息，禁止缓存
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        // 设置响应类型
        response.setContentType("image/jpeg");

        // 输出图片
        javax.imageio.ImageIO.write(image, "JPEG", response.getOutputStream());
    }

    /**
     * 生成随机颜色
     */
    private Color getRandColor(int fc, int bc) {
        Random random = new Random();
        if (fc > 255) fc = 255;
        if (bc > 255) bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }
}