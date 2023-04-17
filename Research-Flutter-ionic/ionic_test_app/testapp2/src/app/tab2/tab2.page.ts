import { Component , OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { ExploreContainerComponent } from '../explore-container/explore-container.component';
import { PushNotifications } from '@capacitor/push-notifications';
import { LocalNotifications } from '@capacitor/local-notifications';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss'],
  standalone: true,
  imports: [IonicModule, ExploreContainerComponent ]
})
export class Tab2Page implements OnInit  {

  constructor() {}

  ngOnInit() {
  
  }


  async alertNotification() {
    try {  
      await LocalNotifications.schedule({
        notifications: [
          {
            title: 'My notification',
            body: 'This is my notification',
            id: 1,
            schedule: { at: new Date(Date.now() + 200 ) },
            sound: undefined,
            attachments: undefined,
            actionTypeId: "",
            extra: null
          }
        ]
      });
    } catch(e ){
      console.log(e);
    }

  }
}
