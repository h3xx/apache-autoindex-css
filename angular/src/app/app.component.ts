import {
    Component,
    ViewEncapsulation,
} from '@angular/core';

@Component({
    encapsulation: ViewEncapsulation.None,
    selector: 'app-root',
    styleUrls: ['./app.component.scss'],
    templateUrl: './app.component.html',
})
export class AppComponent {
    title = 'apache-css';
}
