package com.handloom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.handloom.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
