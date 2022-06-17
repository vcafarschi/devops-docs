package com.bills.pay.service;

import java.util.Date;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bills.pay.dao.entity.InvoiceEntity;
import com.bills.pay.dao.entity.UserDataEntity;
import com.bills.pay.dao.repository.InvoiceRepository;
import com.bills.pay.dao.repository.UserRepository;
import com.bills.pay.model.InvoiceForm;

@Service
public class BillService {

    @Autowired
    InvoiceRepository repository;

    @Autowired
    UserService userService;

    @Autowired
    private JavaMailSender emailSender;

    public Optional<InvoiceEntity> find(final Date data, String serviceProvider, String userName) {
        Date dateFrom=new Date(data.getYear(),data.getMonth(),1);
        Date dateTo=new Date(data.getYear(),data.getMonth(),29);
        String address = userService.getAddressByUsername(userName);

        return repository.findBill(dateFrom, dateTo, serviceProvider, address);

    }

    public Optional<InvoiceEntity> register(final InvoiceForm invoice) {
        Random ran = new Random();
        int x = ran.nextInt(6) + 5;
        InvoiceEntity invoiceEntity = new InvoiceEntity();
        invoiceEntity.setCodulFiscal(invoice.getCodulFiscal());
        invoiceEntity.setContPersonal(invoice.getContPersonal());
        invoiceEntity.setDataEmitere(invoice.getDataEmitere());
        invoiceEntity.setDataExpediere(invoice.getDataExpediere());
        invoiceEntity.setDataLimitaPlata(invoice.getDataLimitaPlata());
        invoiceEntity.setDatorii(invoice.getDatorii());
        invoiceEntity.setIban(invoice.getIban());
        invoiceEntity.setPerioadaCalcul(invoice.getPerioadaCalcul());
        invoiceEntity.setPretLunar(invoice.getPretLunar());
        invoiceEntity.setPret(invoice.getPret());
        invoiceEntity.setAddressByAddressId(invoice.getAddress());
        invoiceEntity.setServiceProviderName(invoice.getServiceProviderName());
        invoiceEntity.setSuma(invoice.getSuma());
        invoiceEntity.setTva(invoice.getTva());
        invoiceEntity.setVolumConsumat(invoice.getVolumConsumat());
        invoiceEntity.setInvoiceId(x);
        sendEmail(userService.getEmailByAddress(invoice.getAddress()));
        return Optional.of(repository.save(invoiceEntity));
    }

    public Optional<Object> sendEmail(final String email) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("facturaMDfactura@gmail.com");
        message.setTo(email);
        message.setSubject("Notificare. Livrare factura.");
        Random rnd = new Random();
        int number = rnd.nextInt(999999)+100000;

        message.setText("Buna ziua, la adresa dvs. a parvenit o chitanță. Pentru pentru a o vizualiza va rugăm să accesați https://www.factura.md/");
        emailSender.send(message);

        return Optional.of(email);
    }
}
