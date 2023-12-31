//Made by David Alexander Adamache

// Import necessary libraries
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// Define the BarChart class
class BarChart {
  // Class fields
  float x, y, width, height; // Position and dimensions of the chart
  PFont font; // Font used for displaying text
  Map<String, Integer> freq; // Map that stores the frequency of each data point
  List<Map.Entry<String, Integer>> top; // List that stores the sorted frequency data
  int dataPart = coarseAnswer; // The index of the data to be displayed on the chart
  int showAmount;
  String destCityNameOrig = "";

  // Constructor
  BarChart(float x, float y, float width, float height, PFont font, int showAmount)
  {
    // Initialise class fields
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.font = font;
    this.freq = new HashMap<String, Integer>();
    this.top = new ArrayList<Map.Entry<String, Integer>>();
    this.showAmount = showAmount;
  }

  // Method for adding data to the chart
  void addData(Data data)
  {
    if (dataPart >= 0)
    {
      // Get the name of the data to be displayed
      String name = getDataName(dataPart);
      // Get the destination city name from the flight data
      String destCityName = data.getStrVal(name);
      if (destCityName.equals("error"))
      {
        // If the destination city name is not a string, convert it to a string
        int destNum = data.getIntVal(name);
        destCityName = String.valueOf(destNum);
      }

      // If the destination city name is already in the frequency map, increment its count
      if (freq.containsKey(destCityName))
      {
        freq.put(destCityName, freq.get(destCityName) + 1);
        // Otherwise, add the destination city name to the frequency map with a count of 1
      } else {
        freq.put(destCityName, 1);
      }
    }
  }

  // Method for showing the top n data points on the chart
  void showTop() {
    if (dataPart >= 0)
    {
      // Sort the frequency map by value (i.e., the count of each data point)
      top.addAll(freq.entrySet());
      Collections.sort(top, (a, b) -> b.getValue().compareTo(a.getValue()));

      // Show the top n data points
      int maxCount = top.get(0).getValue(); // Calculate the maximum frequency value in the data set

      // Draw the y-axis
      stroke(255);
      line(x, y, x, y - height);

      // Add labels for the values on the y-axis
      textAlign(RIGHT);
      int numLabels = 5;
      if (maxCount > 20)
      {
        for (int i = 0; i < numLabels; i++) {
          float yValue = map(i * maxCount / (numLabels - 1), 0, maxCount, 0, height);
          int roundedValue = round(i * maxCount / (numLabels - 1) / 10) * 10;
          text(roundedValue, x - 5, y - yValue);
          line(x - 3, y - yValue, x + 3, y - yValue);
        }
      } else
      {
        for (int i = 0; i < numLabels; i++) {
          float yValue = map(i * maxCount / (numLabels - 1), 0, maxCount, 0, height);
          int roundedValue = round(i * maxCount / (numLabels - 1) / 1) * 1;
          text(roundedValue, x - 5, y - yValue);
          line(x - 3, y - yValue, x + 3, y - yValue);
        }
      }

      // Define the space between bars
      float barSpacing = width * 0.1 / (showAmount + 1);

      float xb = x + barSpacing;
      int count = 0;

      for (Map.Entry<String, Integer> entry : top) {
        if (count >= showAmount) {
          break;
        }

        // Calculate the height of the bar based on the count of the data point
        float barHeight = map(entry.getValue(), 0, maxCount, 0, height);
        // Display the bar on the chart
        fill(255);
        rect(xb, y - barHeight, width * 0.8 / showAmount, barHeight);
        // Display the abbreviation of the data point's name on the chart
        fill(255);
        textFont(font);
        textAlign(LEFT);
        text(entry.getKey(), xb + width/2 * 0.8 / showAmount / 2, y + 20);
        // Increment the x position for the next bar
        count++;
        xb += width * 0.826 / showAmount;
      }
    } else
    {
      text("Sort by a Query first to see a Bar Chart!", 250, 720/2);
    }
  }

  public int getReqData(String input)
  {
    String lowerInput = input.toLowerCase();

    switch(lowerInput)
    {
    case "fl_date":
      return 0;
    case "mkt_carrier":
      return 1;
    case "mkt_carrier_fl_num":
      return 2;
    case "origin":
    case "origin_city_name":
    case "origin_wac":
      return 3;
    case "dest":
    case "destination":
    case "dest_state_abr":
      return 8;
    case "dest_wac":
      return 10;
    case "crs_dep_time":
      return 12;
    case "dep_time":
      return 13;
    case "crs_arr_time":
      return 14;
    case "arr_time":
      return 15;
    case "cancelled":
      return 16;
    case "diverted":
      return 17;
    case "distance":
      return 18;
    }
    return 8;
  }
}

String getDataName(int dP)
{
  switch (dP)
  {
  case 2:
    return "MKT_CARRIER_FL_NUM";
  case 3:
    return "ORIGIN";
  case 0:
    return "FL_DATE";
  case 8:
    return "DEST";
  case 13:
    return "CRS_DEP_TIME";
  case 15:
    return "CRS_ARR_TIME";
  default:
    return "DEST";
  }
}
