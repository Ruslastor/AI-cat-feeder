<h1>AI cat feeder.</h1>
<p> This project aimed to create a cat feeder, which will detect a certain cat, and feed it. The detector will detect different cats, and give a feed in dependence of how much the cat has eaten per day or week. Also, this feeder can save and analyze the statistics of how much each cat has eaten for all periods of work. The data is being displayed, and the device is being controlled through the phone.</p>

<h2>Electronics</h2>
<p>The new electronics was designed as a shield for the Raspberry Pi Zero W 2.
The board consists of:</p>
<ul>
  <li>MCP3008 - 8 channel SPI ADC (Raspberry Pi Zero does not have its own)</li>
  <li>L293B - a DC motor controller (This is quite old-fashioned circuit, but we had only those in University, so, we have what we have :) )</li>
  <li>ACS712 - Analog current sensor</li>
</ul>

<p>The circuitry of the project is drawn here:</p>
<img src="images_ai_cat/Circuitry.png" alt="The circuitry"/>

<table>
  <tr>
    <th>The PCB Gerber file</th>
    <th>The PCB 2D view</th>
    <th>The PCB 3D view</tr>
  </tr>
  <tr>
    <td><img src="images_ai_cat/gerber.png" width=300 alt="The gerber view"/></td>
    <td><img src="images_ai_cat/2d_model.png" width=300 alt="The 2D view"/></td>
    <td><img src="images_ai_cat/3d_model.png" width=300 alt="The 3D view"/></td>
  </tr>
</table>
