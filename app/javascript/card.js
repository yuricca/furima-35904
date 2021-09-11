const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit",(e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      card_number: formData.get("order[card_number]"),
      card_exp_month: formData.get("order[card_exp_month]"),
      card_exp_year: `20${formData.get("order[card_exp_year]")}`,
      card_cvc: formData.get("order[card_cvc]"),
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("order_card_number").removeAttribute("name");
      document.getElementById("order_card_exp_month").removeAttribute("name");
      document.getElementById("order_card_exp_year").removeAttribute("name");
      document.getElementById("order_card_cvc").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);