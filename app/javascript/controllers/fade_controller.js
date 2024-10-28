import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:click", this.fadeOut.bind(this));
    document.addEventListener("turbo:load", this.fadeIn.bind(this));
  }

  fadeOut() {
    this.element.classList.add("fade-out");
  }

  fadeIn() {
    // フェードインを行うために、少し遅延を加えてクラスを削除
    setTimeout(() => {
      this.element.classList.remove("fade-out");
    }, 50); // 短い遅延を入れることで、次回のアニメーションが適切に実行される
  }
}
