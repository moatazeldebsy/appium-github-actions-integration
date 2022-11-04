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

public class DemoTest {

    WebDriver driver;

    @BeforeClass
    public void setUp() throws MalformedURLException {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("automationName" , "espresso");
        caps.setCapability("platformName" , "Android");
        caps.setCapability("appium:platformVersion" , "7.1.1");
        caps.setCapability("appium:deviceName" , "Android Emulator");
        caps.setCapability("appium:app" ,
                System.getProperty("user.dir")+"/apps/selendroid-test-app-0.17.0.apk");
        driver = new AndroidDriver(new URL("http://localhost:4723"), caps);
    }

    @Test
    public void test_Appium() {
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
