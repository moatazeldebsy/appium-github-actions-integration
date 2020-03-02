import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileBy;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;
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
        caps.setCapability("automationName" , "UiAutomator1");
        caps.setCapability("platformName" , "Android");
        caps.setCapability("platformVersion" , "7.1.1");
        caps.setCapability("deviceName" , "Android Emulator");
        caps.setCapability("app" , System.getProperty("user.dir")+"/apps/selendroid-test-app-0.17.0.apk");
        driver = new AndroidDriver<>(new URL("http://localhost:4723/wd/hub"), caps);
    }

    @Test
    public void test_appium() throws MalformedURLException, InterruptedException {

        driver.findElement(By.id("my_text_field")).sendKeys("Hello GitHub Actions");
    }

    @AfterClass
    public void tearDown()
    {
        driver.quit();
    }

}
