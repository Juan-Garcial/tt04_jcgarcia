![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)

# A clock based on seven segments displays 

The heart of this project is a 7-segment clock that provides the display of hours, minutes, and seconds in a clear and readable format. With the ability to choose between a 12-hour or 24-hour format, users have complete control over how they want to perceive time. This feature is especially useful for those who prefer the convenience of one format or the precision of another.

However, customization doesn't stop there. This clock puts the power of choice in the hands of the users by allowing them to select whether they want the displays to be of common anode or common cathode type. This feature is crucial as it provides flexibility in the clock interface and caters to the individual preferences of each user.

Programming this clock is as intuitive as it is powerful. Equipped with two buttons, the user can navigate through the configuration menu and adjust the time accurately and easily.

## Architecture

The design of the clock is based on a scheme similar to the one illustrated in Figure 1. Since the available resources are limited, the decision was made to implement 2 cascading frequency dividers. The first divider, with a ratio of 5000 to 1, generates the clock signal used for segment scanning and also serves as the input for the second frequency divider, which operates at a ratio of 2000 to 1. Together, these two cascading dividers generate a total ratio of 10,000,000 to 1. This ratio is particularly useful considering that the base clock frequency is 10MHz, resulting in a 1Hz signal used to synchronize the movement of the clock's second hand.

With the aim of optimizing space, the decision was made to employ multiplexing instead of implementing a Binary-Coded Decimal (BCD) to 7-segment display converter for each of the clock's digits. Through this multiplexing technique, the display to be shown at a given moment is selected, which in turn reduces the number of output pins needed to control the displays. This becomes especially advantageous since the maximum number of available pins is 8.

Despite the proposed multiplexing strategy for the output ports, the total number of pins required for this configuration remains high. To address this limitation, a configuration was chosen where bit scanning is performed. In other words, at each moment in time, only one segment is turned on, resulting in a dimming of each segment's brightness due to its intermittent activation.

This intermittent lighting feature allows for keeping the use of pins to a minimum, albeit with the trade-off that the segments will not be continuously lit.
## How to enable the GitHub actions to build the ASIC files

Please see the instructions for:

- [Enabling GitHub Actions](https://tinytapeout.com/faq/#when-i-commit-my-change-the-gds-action-isnt-running)
- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## How does it work?

When you edit the info.yaml to choose a different ID, the [GitHub Action](.github/workflows/gds.yaml) will fetch the digital netlist of your design from Wokwi.

After that, the action uses the open source ASIC tool called [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/) to build the files needed to fabricate an ASIC.

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://discord.gg/rPK2nSjxy8)

## What next?

- Submit your design to the next shuttle [on the website](https://tinytapeout.com/#submit-your-design), the closing date is 8th September.
- Share your GDS on Twitter, tag it [#tinytapeout](https://twitter.com/hashtag/tinytapeout?src=hashtag_click) and [link me](https://twitter.com/matthewvenn)!
