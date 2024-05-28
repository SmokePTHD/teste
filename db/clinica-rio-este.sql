-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Maio-2024 às 15:57
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `clinica-rio-este`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `nif` varchar(9) DEFAULT NULL,
  `contato` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `morada` varchar(255) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `codigo_postal` varchar(8) DEFAULT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `consultas`
--

CREATE TABLE `consultas` (
  `id` int(11) NOT NULL,
  `consultorio_id` int(11) DEFAULT NULL,
  `medico_id` int(11) DEFAULT NULL,
  `paciente_id` int(11) DEFAULT NULL,
  `data_hora` datetime DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `status` enum('Agendada','Cancelada','Concluída') DEFAULT 'Agendada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `apelido` varchar(255) NOT NULL,
  `sexo` enum('M','F') NOT NULL,
  `data_nascimento` date NOT NULL,
  `data_adsao` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `telemovel` varchar(15) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cargo` varchar(255) NOT NULL,
  `status` enum('online','offline') NOT NULL,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isDeleted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `foto`, `nome`, `apelido`, `sexo`, `data_nascimento`, `data_adsao`, `email`, `telemovel`, `usuario`, `password`, `cargo`, `status`, `last_activity`, `isDeleted`) VALUES
(1, NULL, 'Gonçalo', 'Sousa', 'M', '2007-02-08', '2024-04-26', 'glapdesousa@gmail.com', '+351932346411', 'Smoke', '$2y$10$9dIedQxStP0PccdSm7pv6.whJB9SLM1FdEFv3zLq1hZyG0IrQ8x.m', 'Gestor', 'online', '2024-05-27 07:54:27', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medico_id` (`medico_id`),
  ADD KEY `paciente_id` (`paciente_id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`paciente_id`) REFERENCES `clientes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
