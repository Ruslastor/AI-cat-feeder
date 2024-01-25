<h1>AI cat feeder.</h1>
<p> This project aimed to create a cat feeder, which will detect a certain cat, and feed it. The detector will detect different cats, and give a feed in dependence of how much the cat has eaten per day or week. Also, this feeder can save and analyze the statistics of how much each cat has eaten for all periods of work. The data is being displayed, and the device is being controlled through the phone.</p>

<h2>Electronics</h2>
<p>The new electronics was designed as a shield for the Raspberry Pi Zero W 2.
The board consists of:</p>
<table>
  <tr>
    <th>Raspberry Pi Zero W 2</th>
  </tr>
  <tr>
    <td><img src="images_ai_cat/RPI.jpg" width=400 alt="Prototype 1"/></td>
  </tr>
</table>
<ul>
  <li>MCP3008 - 8 channel SPI ADC (Raspberry Pi Zero does not have its own)</li>
  <li>L293B - a DC motor controller (This is quite old-fashioned circuit, but we had only those in University, so, we have what we have :) )</li>
  <li>ACS712 - Analog current sensor</li>
  <li>BSS138 - MOSFETs, that are used for voltage level conversion (The motor control module works on 5V logic, and the Raspberry's logic is 3.3V)</li>
</ul>

<p>The circuit outputs are:</p>
<ul>
  <li>Button output - this is the output for the motor button (it is used to detect the motor rotation angle)</li>
  <li>Weight output - this is the output to be used for a weight sensor, to measure the weight of feed inside the bowl</li>
  <li>Motor output - The output is used to connect the motor</li>
  <li>5V output - If we want to implement something in the future, this port will be used (just additional power output)</li>
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

<p>The PCB circuit has SMD and THD components. The components will be soldered using the reflow technique, but THD components will be soldered with the solderer. The power lines have bigger size (twice as big as signal lines). The big copper bottom-layer is circuit ground, and big copper layer on the top-layer is VCC. The vcc is taken from Raspberry's Vbus pin, as soon as is goes directly from USB feeding, without any influence.</p>

<h2>The prototype circuit:</h2>
<table>
  <tr>
    <th><img src="images_ai_cat/prototype_1.jpg" width=400 alt="Prototype 1"/></th>
    <th><img src="images_ai_cat/prototype_2.jpg" width=400 alt="Prototype 2"/></th>
  </tr>
</table>

<h2>Mechanical part</h2>
<p>For this project, in the purpose of concentrating more on the circuit, it was decided to buy an existing automated cat feeder and replace the insides with our own.</p>
<p>The cat feeder we used:</p>
<img src="images_ai_cat/feeder.png" alt="Feeder image" width=300/>
<p>The feeding mechanism works in the way, that the motor rotates till the button is released and pressed again.</p>
<p>The motor motion:</p>
<img src="images_ai_cat/motion.gif" alt="Motor motion", width=300 />

<h2>The AI part</h2>
<p></p>
