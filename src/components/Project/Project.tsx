import React from "react";
import { Container } from "./styles";
import ScrollAnimation from "react-animate-on-scroll";

import img1 from "../../assets/img3.jpg";
import img2 from "../../assets/img9.jpg";
import img3 from "../../assets/img12.jpg";
import img4 from "../../assets/img13.jpg";
import img5 from "../../assets/img7.jpg";
import img6 from "../../assets/img5.jpg";
import img7 from "../../assets/img4.jpg";
import img8 from "../../assets/img11.jpg";
import img9 from "../../assets/img14.jpg";


const images = [img8, img7, img6, img5, img4, img3, img2, img1,img9];

export const Project: React.FC = () => {
  return (
    <Container id="project">
      <h2>Memories</h2>
      <div className="projects">
        {images.map((img, index) => (
          <ScrollAnimation animateIn="flipInX" key={index}>
            <div className="project">
              <img src={img} alt={`Memory ${index + 1}`} className="responsive-img" />
            </div>
          </ScrollAnimation>
        ))}
      </div>
    </Container>
  );
};
