import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.net.MalformedURLException;
import java.net.URL;

public class Demo {

    WebDriver driver;

    @BeforeClass
    public void setUp() throws MalformedURLException {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("automationName" , "espresso");
        caps.setCapability("platformName" , "Android");
        caps.setCapability("platformVersion" , "7.1.1");
        caps.setCapability("deviceName" , "Android Emulator");
        caps.setCapability("app" , System.getProperty("user.dir")+"/apps/selendroid-test-app-0.17.0.apk");
        driver = new AndroidDriver<>(new URL("http://localhost:4723/wd/hub"), caps);
    }

    @Test
    public void test_Appium() throws MalformedURLException, InterruptedException {
        String message = "Hello GitHub Actions";
        WebElement messageTxt = driver.findElement(By.id("my_text_field"));
        messageTxt.sendKeys(message);
        System.out.println(messageTxt.getText());
        Assert.assertEquals(message,messageTxt.getText());
    }

    @AfterClass
    public void tearDown()
    {
        driver.quit();
    }
}
