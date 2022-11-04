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
        caps.setCapability("appium:platformVersion" , "9");
        caps.setCapability("appium:deviceName" , "Android Emulator");
        caps.setCapability("appium:app" ,
                System.getProperty("user.dir")+"/apps/app-debug.apk");
        driver = new AndroidDriver(new URL("http://localhost:4723"), caps);
    }

    @Test
    public void test_Appium() {
        driver.findElement(By.id("buttonFive")).click();
        driver.findElement(By.id("buttonAdd")).click();
        driver.findElement(By.id("buttonFour")).click();
        driver.findElement(By.id("buttonEqual")).click();
    }
    @AfterClass
    public void tearDown()
    {
        driver.quit();
    }
}
