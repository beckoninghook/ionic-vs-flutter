import { Component } from '@angular/core';
import { OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { ExploreContainerComponent } from '../explore-container/explore-container.component';
import { CameraPreview, CameraPreviewOptions } from '@capacitor-community/camera-preview';

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss'],
  standalone: true,
  imports: [IonicModule, ExploreContainerComponent],
})
export class Tab1Page implements OnInit  {
  constructor() {}
  ngOnInit() {
    this.startCameraPreview()
  }
  async startCameraPreview() {
    const cameraPreviewOptions: CameraPreviewOptions = {
      x: 0,
      y: 0,
      width: window.screen.width,
      height: window.screen.height,
      position: 'rear',
      
      toBack: true,
    };
  
    await CameraPreview.start(cameraPreviewOptions);
  }
}
