![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)

# A clock based on seven segments displays 

The heart of this project is a 7-segment clock that provides the display of hours, minutes, and seconds in a clear and readable format. With the ability to choose between a 12-hour or 24-hour format, users have complete control over how they want to perceive time. This feature is especially useful for those who prefer the convenience of one format or the precision of another.

However, customization doesn't stop there. This clock puts the power of choice in the hands of the users by allowing them to select whether they want the displays to be of common anode or common cathode type. This feature is crucial as it provides flexibility in the clock interface and caters to the individual preferences of each user.

Programming this clock is as intuitive as it is powerful. Equipped with two buttons, the user can navigate through the configuration menu and adjust the time accurately and easily.

## Architecture

Edit the [info.yaml](info.yaml) and change the wokwi_id to match your project.

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
